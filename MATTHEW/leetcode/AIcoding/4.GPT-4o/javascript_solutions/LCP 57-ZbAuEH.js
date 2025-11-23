class Solution {
    constructor() {
        this.score = 0;
    }

    hit() {
        this.score += 1;
    }

    getScore() {
        return this.score;
    }
}