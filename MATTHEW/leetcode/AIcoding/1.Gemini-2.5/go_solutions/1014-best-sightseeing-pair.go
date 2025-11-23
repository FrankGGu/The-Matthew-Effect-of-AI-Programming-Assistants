func maxSightseeingPair(values []int) int {
    n := len(values)

    // Initialize maxScore with the score of the first possible pair (i=0, j=1).
    // The score is values[i] + values[j] + i - j.
    // For (0, 1), it's values[0] + values[1] + 0 - 1.
    maxScore := values[0] + values[1] - 1 

    // max_val_i_plus_i stores the maximum (values[k] + k) encountered for k < j.
    // When j starts at 1, the only k < j is k=0. So, initialize with values[0] + 0.
    max_val_i_plus_i := values[0] + 0

    // Iterate j from 1 to n-1.
    // For each j, we want to find the best i < j.
    for j := 1; j < n; j++ {
        // Calculate the score for the current j, using the best (values[i] + i) found so far.
        // The expression values[i] + values[j] + i - j can be rewritten as (values[i] + i) + (values[j] - j).
        currentScore := max_val_i_plus_i + (values[j] - j)

        // Update the overall maximum score found.
        if currentScore > maxScore {
            maxScore = currentScore
        }

        // Update max_val_i_plus_i to include the current j for future iterations.
        // This means max_val_i_plus_i will represent max(values[k] + k) for k <= j.
        // When the loop progresses to j+1, this updated max_val_i_plus_i will correctly represent
        // max(values[k]+k) for k < (j+1).
        if (values[j] + j) > max_val_i_plus_i {
            max_val_i_plus_i = values[j] + j
        }
    }

    return maxScore
}