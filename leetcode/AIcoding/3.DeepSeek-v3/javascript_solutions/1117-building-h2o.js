class H2O {
    constructor() {
        this.hCount = 0;
        this.promise = Promise.resolve();
        this.resolveH = () => {};
        this.resolveO = () => {};
    }

    hydrogen(releaseHydrogen) {
        this.promise = this.promise.then(() => {
            if (this.hCount < 2) {
                this.hCount++;
                releaseHydrogen();
                if (this.hCount === 2) {
                    this.resolveH();
                }
            } else {
                return new Promise(resolve => {
                    this.resolveH = () => {
                        this.hCount = 1;
                        releaseHydrogen();
                        resolve();
                    };
                });
            }
        });
    }

    oxygen(releaseOxygen) {
        this.promise = this.promise.then(() => {
            if (this.hCount === 2) {
                releaseOxygen();
                this.hCount = 0;
                this.resolveO();
            } else {
                return new Promise(resolve => {
                    this.resolveO = () => {
                        releaseOxygen();
                        resolve();
                    };
                });
            }
        });
    }
}