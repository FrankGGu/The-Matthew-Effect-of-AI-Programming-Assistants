package main

var memo [32][2][32]int
var targetK int

func ways(currentPos int, lastDownFlag int, upMoves int) int {
	if currentPos < 0 || currentPos > targetK+1 {
		return 0
	}
	if upMoves > targetK+1 {
		return 0
	}

	if memo[currentPos][lastDownFlag][upMoves] != -1 {
		return memo[currentPos][lastDownFlag][upMoves]
	}

	result := 0
	if currentPos == targetK {
		result = 1
	}

	result += ways(currentPos+1, 0, upMoves+1)

	if lastDownFlag == 0 && currentPos > 0 {
		result += ways(currentPos-1, 1, upMoves)
	}

	memo[currentPos][lastDownFlag][upMoves] = result
	return result
}

func waysToReachStair(k int) int {
	for i := 0; i < 32; i++ {
		for j := 0; j < 2; j++ {
			for l := 0; l < 32; l++ {
				memo[i][j][l] = -1
			}
		}
	}

	targetK = k

	return ways(0, 0, 0)
}