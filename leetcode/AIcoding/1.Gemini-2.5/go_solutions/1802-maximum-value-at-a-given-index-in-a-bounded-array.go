func maxValue(n int, index int, maxSum int) int {
    // Helper function to calculate the sum of an arithmetic progression
    // starting from 'peak' and decreasing by 1 for 'length' elements,
    // ensuring no element goes below 1.
    // For example, if peak=5, length=3, sum is 5+