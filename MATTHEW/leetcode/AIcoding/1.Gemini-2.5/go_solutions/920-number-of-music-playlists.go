import "fmt"

func numMusicPlaylists(n int, l int, k int) int {
	const MOD int = 1e9 + 7

	// dp[i][j] represents the number of playlists of length i using j distinct songs.
	dp := make([][]int, l+1)
	for