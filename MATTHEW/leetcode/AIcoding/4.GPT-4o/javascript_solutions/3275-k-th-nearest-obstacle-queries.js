class KthNearestObstacles {
    constructor(obstacles) {
        this.obstacles = obstacles;
    }

    query(p, k) {
        const distances = this.obstacles.map(obs => Math.abs(obs - p)).sort((a, b) => a - b);
        return distances.length >= k ? distances[k - 1] : -1;
    }
}