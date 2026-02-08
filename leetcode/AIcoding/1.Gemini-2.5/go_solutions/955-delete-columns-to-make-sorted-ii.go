func minDeletionSize(strs []string) int {
    N := len(strs)
    if N <= 1 {
        return 0
    }
    M := len(strs[0])
    if M == 0 {
        return 0
    }

    deletedCount := 0
    isSorted := make([]