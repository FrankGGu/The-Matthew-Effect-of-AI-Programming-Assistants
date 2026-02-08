import "sort"

func asteroidsDestroyed(mass int, asteroids []int) bool {
    // Convert the initial mass to int64 to prevent potential overflow
    // as the total mass can grow very large (up to 10^5 + 10^5 * 10^5 = 10^10 + 10^5).
    currentMass := int64(mass)

    // To maximize our chances of destroying all asteroids, we should always
    // destroy the smallest asteroids first. This ensures our mass grows
    // as much as possible before encountering larger asteroids.
    sort.Ints(asteroids)

    // Iterate through the sorted asteroids
    for _, asteroidMass := range asteroids {
        // If our current mass is less than the asteroid's mass, we cannot destroy it.
        // Since the asteroids are sorted, we won't be able to destroy any subsequent
        // (larger) asteroids either.
        if currentMass < int64(asteroidMass) {
            return false
        }
        // If we can destroy the asteroid, add its mass to our current mass.
        currentMass += int64(asteroidMass)
    }

    // If we successfully iterated through all asteroids, it means we destroyed them all.
    return true
}