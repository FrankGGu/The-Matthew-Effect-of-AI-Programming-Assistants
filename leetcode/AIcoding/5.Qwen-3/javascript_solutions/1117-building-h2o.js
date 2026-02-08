var H2O = function(releaseHydrogen) {
    let hCount = 0;
    let oCount = 0;
    const lock = new Promise((resolve) => resolve());

    this.hydrogen = () => {
        lock.then(() => {
            hCount++;
            if (hCount === 2 && oCount === 1) {
                releaseHydrogen();
                releaseHydrogen();
                hCount = 0;
                oCount = 0;
            }
        });
    };

    this.oxygen = () => {
        lock.then(() => {
            oCount++;
            if (hCount === 2 && oCount === 1) {
                releaseHydrogen();
                releaseHydrogen();
                hCount = 0;
                oCount = 0;
            }
        });
    };
};