var ZeroEvenOdd = function(n) {
    this.n = n;
    this.currentNum = 1; // The number to be printed (1 to n)
    this.turn = 0; // 0: zero's turn, 1: odd's turn, 2: even's turn

    // Promises and their resolvers for coordination
    this.zeroPromise = null;
    this.oddPromise = null;
    this.evenPromise = null;

    this.zeroResolve = null;
    this.oddResolve = null;
    this.evenResolve = null;

    // Initialize the first promise for zero, as it always starts the sequence
    this.zeroPromise = new Promise(resolve => {
        this.zeroResolve = resolve;
    });
};

ZeroEvenOdd.prototype.zero = async function(printNumber) {
    for (let i = 0; i < this.n; i++) {
        // Wait for zero's turn
        while (this.turn !== 0) {
            this.zeroPromise = new Promise(resolve => {
                this.zeroResolve = resolve;
            });
            await this.zeroPromise;
        }

        printNumber(0);

        // Determine whose turn is next based on currentNum
        if (this.currentNum % 2 === 1) { // Next is odd
            this.turn = 1;
            if (this.oddResolve) {
                this.oddResolve();
            }
        } else { // Next is even
            this.turn = 2;
            if (this.evenResolve) {
                this.evenResolve();
            }
        }
    }
    // After all zeros are printed, ensure any potentially waiting odd/even threads are unblocked
    // This handles cases where n is odd (even needs to be unblocked) or n is even (odd needs to be unblocked)
    // so they can terminate gracefully.
    if (this.turn === 1 && this.oddResolve) {
        this.oddResolve();
    } else if (this.turn === 2 && this.evenResolve) {
        this.evenResolve();
    }
};

ZeroEvenOdd.prototype.odd = async function(printNumber) {
    while (this.currentNum <= this.n) {
        while (this.turn !== 1) {
            this.oddPromise = new Promise(resolve => {
                this.oddResolve = resolve;
            });
            await this.oddPromise;
            // If currentNum has exceeded n while waiting, exit the loop
            if (this.currentNum > this.n) return;
        }

        // It's odd's turn and currentNum is within bounds
        printNumber(this.currentNum);
        this.currentNum++;

        // It's zero's turn next
        this.turn = 0;
        if (this.zeroResolve) {
            this.zeroResolve();
        }
    }
};

ZeroEvenOdd.prototype.even = async function(printNumber) {
    while (this.currentNum <= this.n) {
        while (this.turn !== 2) {
            this.evenPromise = new Promise(resolve => {
                this.evenResolve = resolve;
            });
            await this.evenPromise;
            // If currentNum has exceeded n while waiting, exit the loop
            if (this.currentNum > this.n) return;
        }

        // It's even's turn and currentNum is within bounds
        printNumber(this.currentNum);
        this.currentNum++;

        // It's zero's turn next
        this.turn = 0;
        if (this.zeroResolve) {
            this.zeroResolve();
        }
    }
};