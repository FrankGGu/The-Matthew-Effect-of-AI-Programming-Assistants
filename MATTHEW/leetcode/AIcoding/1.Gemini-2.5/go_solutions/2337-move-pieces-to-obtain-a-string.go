func canChange(start string, target string) bool {
    n := len(start)
    i, j := 0, 0

    for i < n && j < n {
        // Skip '_' characters in start
        for i < n && start[i] == '_' {
            i++
        }
        // Skip '_' characters in target
        for j < n && target[j] == '_' {
            j++
        }

        // If one string has remaining pieces and the other doesn't, or both reached end
        if i == n || j == n {
            break
        }

        // If pieces don't match
        if start[i] != target[j] {
            return false
        }

        // Check movement constraints
        if start[i] == 'L' {
            // 'L' can only move left, so its start index must be >= target index
            if i < j {
                return false
            }
        } else { // start[i] == 'R'
            // 'R' can only move right, so its start index must be <= target index
            if i > j {
                return false
            }
        }

        i++
        j++
    }

    // After the loop, ensure both pointers have reached the end of their strings
    // (after skipping any remaining trailing '_')
    for i < n && start[i] == '_' {
        i++
    }
    for j < n && target[j] == '_' {
        j++
    }

    return i == n && j == n
}