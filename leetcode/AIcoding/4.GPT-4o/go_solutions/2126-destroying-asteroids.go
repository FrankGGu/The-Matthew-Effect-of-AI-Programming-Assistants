func asteroidsDestroyed(mass int64, asteroids []int) bool {
    var totalMass int64 = mass
    sort.Slice(asteroids, func(i, j int) bool {
        return asteroids[i] < asteroids[j]
    })

    for _, asteroid := range asteroids {
        if totalMass < int64(asteroid) {
            return false
        }
        totalMass += int64(asteroid)
    }
    return true
}