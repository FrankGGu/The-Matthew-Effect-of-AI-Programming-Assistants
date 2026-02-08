package main

func asteroidsDestroyed(n int, asteroids []int) bool {
    for _, asteroid := range asteroids {
        if n < asteroid {
            return false
        }
        n += asteroid
    }
    return true
}