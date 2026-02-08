package main

func garbageCollection(garbage []string, travel []string) int {
    n := len(garbage)
    time := 0

    for i := 0; i < n; i++ {
        time += len(garbage[i])
    }

    for i := 0; i < len(travel); i++ {
        if containsGarbage(garbage, 'G') {
            time += int(travel[i][0] - '0')
        }
        if containsGarbage(garbage, 'P') {
            time += int(travel[i][0] - '0')
        }
        if containsGarbage(garbage, 'M') {
            time += int(travel[i][0] - '0')
        }
    }

    return time
}

func containsGarbage(garbage []string, c byte) bool {
    for _, s := range garbage {
        if contains(s, c) {
            return true
        }
    }
    return false
}

func contains(s string, c byte) bool {
    for i := 0; i < len(s); i++ {
        if s[i] == c {
            return true
        }
    }
    return false
}