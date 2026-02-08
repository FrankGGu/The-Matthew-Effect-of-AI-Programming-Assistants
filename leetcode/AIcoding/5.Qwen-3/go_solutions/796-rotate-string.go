package main

func rotateString(s string, goal string) bool {
    if len(s) != len(goal) {
        return false
    }
    return len(s+goal) > 0 && (s+s)[0:len(s)] == goal
}