import "math"

func PredictTheWinner(nums []int) bool {
	n := len(nums)

	// dp[i][j] stores the maximum score difference (Player1's score - Player2's score)
	// that the current player can achieve when playing on the subarray nums[i...j].
	dp