func numberOfWeeks(milestones []int) int64 {
	var sum int64
	var maxVal int64

	for _, m := range milestones {
		currentMilestone := int64(m)
		sum += currentMilestone
		if currentMilestone > maxVal {
			maxVal = currentMilestone
		}
	}

	// If the largest project's tasks can be fully interleaved with tasks from other projects,
	// then all tasks can be completed.
	// This condition is met if maxVal <= (sum - maxVal) + 1.
	// (sum - maxVal) represents the total tasks from all other projects.
	// We need at least (maxVal - 1) tasks from other projects to separate all maxVal tasks.
	// If (sum - maxVal) >= (maxVal - 1), then we can complete all tasks, resulting in 'sum' weeks.
	// The condition simplifies to sum >= 2 * maxVal - 1, or maxVal <= sum - maxVal + 1.
	if maxVal <= sum-maxVal+1 {
		return sum
	} else {
		// If the largest project is too big, we cannot complete all its tasks.
		// We can use all (sum - maxVal) tasks from other projects to interleave with
		// (sum - maxVal) tasks from the largest project. This accounts for 2 * (sum - maxVal) weeks.
		// After this, all other projects are exhausted.
		// We are left with maxVal - (sum - maxVal) tasks from the largest project.
		// Since we cannot work on the same project for two consecutive weeks, and there are no
		// other projects left, we can only work on one more task from the largest project
		// (as the last week worked on an "other" project).
		// So, the total weeks will be 2 * (sum - maxVal) + 1.
		return 2*(sum-maxVal) + 1
	}
}