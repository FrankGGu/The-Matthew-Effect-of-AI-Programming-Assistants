import (
	"math"
)

func minimumFinishTime(tires [][]int, changeTime int, numLaps int) int {
	maxLaps := min(numLaps, 17)
	bestTime := make([]int, maxLaps+1)
	for i := 1; i <= maxLaps; i++ {
		bestTime[i] = math.MaxInt32
	}

	for _, tire := range tires {
		f, r := tire[0], tire[1]
		time := f
		for laps := 1; laps <= maxLaps && time < math.MaxInt32; laps++ {
			bestTime[laps] = min(bestTime[laps], time)
			if (math.MaxInt32-r)/f < 1 {
				break
			}
			f *= r
			if time > math.MaxInt32-f {
				break
			}
			time += f
		}
	}

	dp := make([]int, numLaps+1)
	for i := 1; i <= numLaps; i++ {
		dp[i] = math.MaxInt32
		for j := 1; j <= min(i, maxLaps); j++ {
			if dp[i-j] == math.MaxInt32 || bestTime[j] == math.MaxInt32 {
				continue
			}
			dp[i] = min(dp[i], dp[i-j]+bestTime[j]+changeTime)
		}
	}

	return dp[numLaps] - changeTime
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}