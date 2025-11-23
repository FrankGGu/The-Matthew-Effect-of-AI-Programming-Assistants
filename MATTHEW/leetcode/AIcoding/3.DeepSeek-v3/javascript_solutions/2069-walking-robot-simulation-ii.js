var Robot = function(width, height) {
    this.width = width;
    this.height = height;
    this.pos = [0, 0];
    this.dir = "East";
    this.perimeter = 2 * (width + height) - 4;
    this.moves = 0;
};

Robot.prototype.step = function(num) {
    this.moves += num;
    this.moves %= this.perimeter;
    if (this.moves === 0) {
        this.moves = this.perimeter;
    }
    this.updatePosAndDir();
};

Robot.prototype.updatePosAndDir = function() {
    if (this.moves <= this.width - 1) {
        this.pos = [this.moves, 0];
        this.dir = this.moves === this.width - 1 ? "North" : "East";
    } else if (this.moves <= this.width + this.height - 2) {
        this.pos = [this.width - 1, this.moves - (this.width - 1)];
        this.dir = this.moves === this.width + this.height - 2 ? "West" : "North";
    } else if (this.moves <= 2 * this.width + this.height - 3) {
        this.pos = [this.width - 1 - (this.moves - (this.width + this.height - 2)), this.height - 1];
        this.dir = this.moves === 2 * this.width + this.height - 3 ? "South" : "West";
    } else {
        this.pos = [0, this.height - 1 - (this.moves - (2 * this.width + this.height - 3))];
        this.dir = this.moves === this.perimeter ? "East" : "South";
    }
};

Robot.prototype.getPos = function() {
    return this.pos;
};

Robot.prototype.getDir = function() {
    return this.dir;
};