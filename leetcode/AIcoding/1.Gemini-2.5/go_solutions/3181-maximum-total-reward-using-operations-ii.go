func maxTotalReward(rewardValues []int) int {
	// Sort the reward values in ascending order.
	// This helps in processing rewards such that the condition current_reward < reward[i]
	// naturally implies that reward[i] is greater than previously considered rewards.
	sort.Int