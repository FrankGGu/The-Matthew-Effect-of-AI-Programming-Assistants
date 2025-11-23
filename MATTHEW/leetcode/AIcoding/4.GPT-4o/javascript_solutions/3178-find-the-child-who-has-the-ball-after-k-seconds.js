function findTheChild(ball, k) {
    const n = ball.length;
    return ball[(k % (2 * n)) % n];
}