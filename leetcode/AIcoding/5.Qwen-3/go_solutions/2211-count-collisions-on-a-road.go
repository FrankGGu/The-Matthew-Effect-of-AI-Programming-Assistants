package main

func countCollisions(s string) int {
    n := len(s)
    count := 0
    i := 0
    // Move to the first non-'L' character
    for i < n && s[i] == 'L' {
        i++
    }
    // If all are 'L', no collision
    if i == n {
        return 0
    }
    // Now, process from i to end
    prev := s[i]
    i++
    for i < n {
        curr := s[i]
        if curr == 'S' {
            // If previous is 'R', collision happens
            if prev == 'R' {
                count++
            }
            prev = curr
        } else if curr == 'L' {
            // If previous is 'R', collision happens
            if prev == 'R' {
                count++
            }
            // If previous is 'S', no collision
            prev = curr
        } else { // curr == 'R'
            // If previous is 'R', no collision
            if prev == 'R' {
                prev = curr
            } else {
                // If previous is 'S', then current 'R' will not collide
                prev = curr
            }
        }
        i++
    }
    return count
}