class H2O {
    constructor() {
        this.hCount = 0;
        this.oCount = 0;
        this.hQueue = [];
        this.oQueue = [];
    }

    hydrogen(callback) {
        this.hQueue.push(callback);
        this.hCount++;
        this.tryToMakeWater();
    }

    oxygen(callback) {
        this.oQueue.push(callback);
        this.oCount++;
        this.tryToMakeWater();
    }

    tryToMakeWater() {
        while (this.hCount >= 2 && this.oCount >= 1) {
            this.hCount -= 2;
            this.oCount -= 1;
            this.hQueue.shift()();
            this.hQueue.shift()();
            this.oQueue.shift()();
        }
    }
}