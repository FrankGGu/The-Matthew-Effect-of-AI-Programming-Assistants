package main

func minMovesToCaptureTheQueen(p1 []int, p2 []int, b1 []int, b2 []int) int {
    // Check if the path between p1 and p2 is blocked by a bishop
    if (p1[0]+p1[1])%2 == (p2[0]+p2[1])%2 {
        // Same color square, check if any bishop blocks the path
        if (b1[0]+b1[1])%2 == (p1[0]+p1[1])%2 && isBetween(p1, p2, b1) {
            return 2
        }
        if (b2[0]+b2[1])%2 == (p1[0]+p1[1])%2 && isBetween(p1, p2, b2) {
            return 2
        }
    } else {
        // Different color squares, no bishop can block
        return 1
    }
    return 1
}

func isBetween(a, b, c []int) bool {
    if a[0] == b[0] && a[0] == c[0] {
        return (c[1] > a[1] && c[1] < b[1]) || (c[1] < a[1] && c[1] > b[1])
    }
    if a[1] == b[1] && a[1] == c[1] {
        return (c[0] > a[0] && c[0] < b[0]) || (c[0] < a[0] && c[0] > b[0])
    }
    return false
}