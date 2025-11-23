int maxScore(int a, int b, int c) {
    int p1 = a, p2 = b, p3 = c;

    // Sort p1, p2, p3 in ascending order
    if (p1 > p2) {
        int temp = p1;
        p1 = p2;
        p2 = temp;
    }
    if (p2 > p3) {
        int temp = p2;
        p2 = p3;
        p3 = temp;
    }
    if (p1 > p2) {
        int temp = p1;
        p1 = p2;
        p2 = temp;
    }

    // Now p1 <= p2 <= p3

    // If the largest pile (p3) is greater than the sum of the other two piles (p1 + p2),
    // we can only perform operations until p1 and p2 are exhausted.
    // Each operation involves p3 and one of p1 or p2.
    // The maximum score will be p1 + p2.
    if (p3 > p1 + p2) {
        return p1 + p2;
    } else {
        // If the largest pile (p3) is less than or equal to the sum of the other two piles (p1 + p2),
        // we can always find two piles to remove stones from until at most one stone remains in total.
        // The total number of operations will be half the total sum of stones.
        return (p1 + p2 + p3) / 2;
    }
}