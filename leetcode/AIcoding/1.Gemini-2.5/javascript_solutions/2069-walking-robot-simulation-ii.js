var Robot = function(width, height) {
    this.width = width;
    this.height = height;
    this.w = width - 1;
    this.h = height - 1;
    this.P = 2 * this.w + 2 * this.h;

    this.x = 0;
    this.y = 0;
    this.d = 0; // current distance along perimeter from (0,0) clockwise

    this.dirs = ["East", "North", "West", "South"];
    this.currentDirIndex = 0; // Initial direction is East (0)

    this.moved = false; // To distinguish initial (0,0) from wrapped (0,0)
};

Robot.prototype.step = function(num) {
    this.moved = true; // Robot has moved at least once

    if (this.P === 0) { // Case: width=1, height=1. Only one point (0,0).
        this.x = 0;
        this.y = 0;
        this.d = 0;
        this.currentDirIndex = 0; // Always East for (0,0) in this case
        return;
    }

    this.d = (this.d + num) % this.P;

    // Determine x, y, and currentDirIndex based on this.d
    // The order of these if-else if conditions is important.
    // d=0 falls into the first condition.
    if (this.d <= this.w) { // East segment: (0,0) to (w,0)
        this.x = this.d;
        this.y = 0;
        this.currentDirIndex = 0; // East
    } else if (this.d <= this.w + this.h) { // North segment: (w,0) to (w,h)
        this.x = this.w;
        this.y = this.d - this.w;
        this.currentDirIndex = 1; // North
    } else if (this.d <= this.w + this.h + this.w) { // West segment: (w,h) to (0,h)
        this.x = this.w - (this.d - (this.w + this.h));
        this.y = this.h;
        this.currentDirIndex = 2; // West
    } else { // South segment: (0,h) to (0,0)
        this.x = 0;
        this.y = this.h - (this.d - (2 * this.w + this.h));
        this.currentDirIndex = 3; // South
    }

    // Special rule for (0,0) direction, applied *after* general segment direction.
    // This rule only applies if the robot has moved (i.e., not initial state).
    // If it's at (0,0) and it has moved, then its direction is "South" if it came from (0,1), else "East".
    // This specific condition (width=1, height>1) means (0,0) is always reached from (0,1) when wrapping around.
    // In this case, the `currentDirIndex` should be South, overriding the default East set for d=0.
    if (this.x === 0 && this.y === 0 && this.moved && this.width === 1 && this.height > 1) {
        this.currentDirIndex = 3; // South
    }
    // For all other cases where (x,y)=(0,0) and moved, the general segment logic (setting to East) is correct.
    // E.g., if width>1, height=1, and d=0, it came from (1,0), so East.
    // E.g., if width>1, height>1, and d=0, it came from (1,0), so East.
    // The initial state (x=0, y=0, moved=false) is always East.
};

Robot.prototype.getPos = function() {
    return [this.x, this.y];
};

Robot.prototype.getDir = function() {
    return this.dirs[this.currentDirIndex];
};