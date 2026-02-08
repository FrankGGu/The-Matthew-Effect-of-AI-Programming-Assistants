package main

const (
	DRAW      = 0
	MOUSE_WIN = 1
	CAT_WIN   = 2
)

var (
	N, M int
	catJump, mouseJump int
	grid []string
	// dp[cat_r][cat_c][mouse_r][mouse_c][turn][moves]
	// N, M <= 8. So 8x8x8x8x2 states.
	// maxMoves = 2 * N * M. Max 2 * 8 * 8 = 128. So 129 for 0..128.
	dp [8][8][8][8][2][129]int

	// Directions for movement (up, down, left, right)
	dr = []int{-1, 1, 0, 0}
	dc = []int{0, 0, -1, 1}
)

func solve(catR, catC, mouseR, mouseC, turn, moves int) int {
	// Base case 1: Max moves reached, it's a draw
	if moves >= 2*N*M { // Using 2*N*M directly instead of maxMoves global for clarity, same value
		return DRAW
	}

	// Base case 2: Check for immediate wins based on current positions
	// If cat is on mouse's cell, cat wins
	if catR == mouseR && catC == mouseC {
		return CAT_WIN
	}
	// If mouse is on food and cat is not on mouse's cell, mouse wins
	if grid[mouseR][mouseC] == 'F' {
		return MOUSE_WIN
	}

	// Check memoization table
	if dp[catR][catC][mouseR][mouseC][turn][moves] != -1 {
		return dp[catR][catC][mouseR][mouseC][turn][moves]
	}

	var result int
	if turn == 0 { // Mouse's turn
		// Mouse wants to achieve MOUSE_WIN. If not possible, DRAW. Otherwise, CAT_WIN.
		mouseCanWin := false
		mouseCanDraw := false

		// Iterate through all possible moves for the mouse
		for i := 0; i < 4; i++ { // 4 directions
			for j := 0; j <= mouseJump; j++ { // 0 to mouseJump steps
				nextMR, nextMC := mouseR+dr[i]*j, mouseC+dc[i]*j

				// Check boundaries and walls
				if nextMR < 0 || nextMR >= N || nextMC < 0 || nextMC >= M || grid[nextMR][nextMC] == '#' {
					// If we hit a wall or go off-grid, we cannot move further in this direction.
					// If j=0 and current cell is a wall, it's an issue, but M/C start on valid cells.
					if j == 0 { // Staying in place is always valid if current cell is not a wall.
						continue
					}
					break // Cannot pass through walls, or move off grid
				}

				// Evaluate the outcome of this specific move
				var currentMoveOutcome int
				if nextMR == catR && nextMC == catC {
					// Mouse moves to cat's cell, cat eats mouse. Cat wins.
					currentMoveOutcome = CAT_WIN
				} else if grid[nextMR][nextMC] == 'F' {
					// Mouse reaches food, cat is not there. Mouse wins.
					currentMoveOutcome = MOUSE_WIN
				} else {
					// No immediate win/loss, recurse for the next state (Cat's turn)
					currentMoveOutcome = solve(catR, catC, nextMR, nextMC, 1, moves+1)
				}

				if currentMoveOutcome == MOUSE_WIN {
					mouseCanWin = true
					break // Mouse found a winning move, no need to check further
				} else if currentMoveOutcome == DRAW {
					mouseCanDraw = true
				}
			}
			if mouseCanWin {
				break
			}
		}

		if mouseCanWin {
			result = MOUSE_WIN
		} else if mouseCanDraw {
			result = DRAW
		} else {
			result = CAT_WIN // All mouse moves lead to cat win
		}

	} else { // Cat's turn (turn == 1)
		// Cat wants to achieve CAT_WIN. If not possible, DRAW. Otherwise, MOUSE_WIN.
		catCanWin := false
		catCanDraw := false

		// Iterate through all possible moves for the cat
		for i := 0; i < 4; i++ { // 4 directions
			for j := 0; j <= catJump; j++ { // 0 to catJump steps
				nextCR, nextCC := catR+dr[i]*j, catC+dc[i]*j

				// Check boundaries and walls
				if nextCR < 0 || nextCR >= N || nextCC < 0 || nextCC >= M || grid[nextCR][nextCC] == '#' {
					if j == 0 {
						continue
					}
					break // Cannot pass through walls, or move off grid
				}

				// Evaluate the outcome of this specific move
				var currentMoveOutcome int
				if nextCR == mouseR && nextCC == mouseC {
					// Cat moves to mouse's cell, cat eats mouse. Cat wins.
					currentMoveOutcome = CAT_WIN
				} else {
					// No immediate win/loss, recurse for the next state (Mouse's turn)
					currentMoveOutcome = solve(nextCR, nextCC, mouseR, mouseC, 0, moves+1)
				}
				// Note: If cat reaches food, but mouse is not there, it's not an immediate win for cat.
				// The game continues.

				if currentMoveOutcome == CAT_WIN {
					catCanWin = true
					break // Cat found a winning move, no need to check further
				} else if currentMoveOutcome == DRAW {
					catCanDraw = true
				}
			}
			if catCanWin {
				break
			}
		}

		if catCanWin {
			result = CAT_WIN
		} else if catCanDraw {
			result = DRAW
		} else {
			result = MOUSE_WIN // All cat moves lead to mouse win
		}
	}

	dp[catR][catC][mouseR][mouseC][turn][moves] = result
	return result
}

func canMouseWin(gridInput []string, catJumpInput int, mouseJumpInput int) int {
	grid = gridInput
	catJump = catJumpInput
	mouseJump = mouseJumpInput

	N = len(grid)
	M = len(grid[0])

	var mouseStartR, mouseStartC int
	var catStartR, catStartC int

	// Find starting positions of mouse and cat
	for r := 0; r < N; r++ {
		for c := 0; c < M; c++ {
			if grid[r][c] == 'M' {
				mouseStartR, mouseStartC = r, c
			} else if grid[r][c] == 'C' {
				catStartR, catStartC = r, c
			}
		}
	}

	// Initialize DP table with -1 (unvisited) for each test case
	for cr := 0; cr < N; cr++ {
		for cc := 0; cc < M; cc++ {
			for mr := 0; mr < N; mr++ {
				for mc := 0; mc < M; mc++ {
					for t := 0; t < 2; t++ {
						for mv := 0; mv <= 2*N*M; mv++ {
							dp[cr][cc][mr][mc][t][mv] = -1
						}
					}
				}
			}
		}
	}

	// Start the game with mouse's turn (turn 0) and 0 moves
	if solve(catStartR, catStartC, mouseStartR, mouseStartC, 0, 0) == MOUSE_WIN {
		return 1 // Mouse can win
	}
	return 0 // Mouse cannot win (either cat wins or it's a draw)
}