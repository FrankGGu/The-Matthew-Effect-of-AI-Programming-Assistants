package main

func mirrorReflection(peakHeight int, peakWidth int) int {
    // Calculate the least common multiple of peakHeight and peakWidth
    lcm := peakHeight * peakWidth / gcd(peakHeight, peakWidth)

    // Determine how many times the height and width fit into the LCM
    m := lcm / peakHeight
    n := lcm / peakWidth

    // If m is even, the reflection is on the right side
    if m % 2 == 0 {
        return 2
    }

    // If n is even, the reflection is on the left side
    if n % 2 == 0 {
        return 1
    }

    // Otherwise, it's on the top
    return 0
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a % b
    }
    return a
}