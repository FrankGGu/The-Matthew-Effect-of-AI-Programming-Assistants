var Solution = function(radius, x_center, y_center) {
    this.radius = radius;
    this.x_center = x_center;
    this.y_center = y_center;
};

Solution.prototype.randPoint = function() {
    while (true) {
        const x = this.x_center - this.radius + Math.random() * (2 * this.radius);
        const y = this.y_center - this.radius + Math.random() * (2 * this.radius);

        const dx = x - this.x_center;
        const dy = y - this.y_center;

        if (dx * dx + dy * dy <= this.radius * this.radius) {
            return [x, y];
        }
    }
};