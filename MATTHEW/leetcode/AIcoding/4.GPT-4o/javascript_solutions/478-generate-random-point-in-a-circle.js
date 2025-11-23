class Solution {
    constructor(radius, x_center, y_center) {
        this.radius = radius;
        this.x_center = x_center;
        this.y_center = y_center;
    }

    randPoint() {
        let r = Math.sqrt(Math.random()) * this.radius;
        let theta = Math.random() * 2 * Math.PI;
        let x = this.x_center + r * Math.cos(theta);
        let y = this.y_center + r * Math.sin(theta);
        return [x, y];
    }
}