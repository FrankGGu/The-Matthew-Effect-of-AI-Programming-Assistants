class Solution {
    constructor(nums) {
        this.original = nums;
        this.shuffled = [...nums];
    }

    reset() {
        return this.original;
    }

    shuffle() {
        for (let i = this.shuffled.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [this.shuffled[i], this.shuffled[j]] = [this.shuffled[j], this.shuffled[i]];
        }
        return this.shuffled;
    }
}