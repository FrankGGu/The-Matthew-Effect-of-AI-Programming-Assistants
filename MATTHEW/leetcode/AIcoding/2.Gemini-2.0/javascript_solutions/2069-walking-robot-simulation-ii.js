class Robot {
    constructor(width, height) {
        this.width = width;
        this.height = height;
        this.pos = [0, 0];
        this.dir = "East";
        this.perimeter = 2 * (width + height) - 4;
    }

    step(num) {
        num %= this.perimeter;
        if (num === 0) num = this.perimeter;

        while (num > 0) {
            if (this.dir === "East") {
                let move = Math.min(num, this.width - 1 - this.pos[0]);
                this.pos[0] += move;
                num -= move;
                if (this.pos[0] === this.width - 1 && num > 0) {
                    this.dir = "North";
                }
            } else if (this.dir === "North") {
                let move = Math.min(num, this.height - 1 - this.pos[1]);
                this.pos[1] += move;
                num -= move;
                if (this.pos[1] === this.height - 1 && num > 0) {
                    this.dir = "West";
                }
            } else if (this.dir === "West") {
                let move = Math.min(num, this.pos[0]);
                this.pos[0] -= move;
                num -= move;
                if (this.pos[0] === 0 && num > 0) {
                    this.dir = "South";
                }
            } else {
                let move = Math.min(num, this.pos[1]);
                this.pos[1] -= move;
                num -= move;
                if (this.pos[1] === 0 && num > 0) {
                    this.dir = "East";
                }
            }
        }
    }

    getPos() {
        return this.pos;
    }

    getDir() {
        return this.dir;
    }
}