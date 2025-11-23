class Solution {
    constructor(radius, x_center, y_center) {
        this.radius = radius;
        this.x_center = x_center;
        this.y_center = y_center;
    }

    randPoint() {
        const angle = Math.random() * 2 * Math.PI;
        const r = Math.sqrt(Math.random()) * this.radius;
        const x = this.x_center + r * Math.cos(angle);
        const y = this.y_center + r * Math.sin(angle);
        return [x, y];
    }
}