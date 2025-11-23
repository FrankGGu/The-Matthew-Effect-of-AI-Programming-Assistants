func minimumEffort(tasks [][]int) int {
	// Sort tasks based on a custom comparator.
	// The intuition is to prioritize tasks that have a larger difference between
	// their minimum required energy and actual consumption (minimum_i - actual_i).
	// If the differences are equal, tasks with