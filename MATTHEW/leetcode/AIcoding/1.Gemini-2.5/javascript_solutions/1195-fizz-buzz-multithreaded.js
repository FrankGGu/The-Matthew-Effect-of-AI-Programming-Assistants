var FizzBuzz = function(n) {
    this.n = n;
    this.current = 1;
};

FizzBuzz.prototype.fizz = async function(printFizz) {
    while (this.current <= this.n) {
        if (this.current % 3 === 0 && this.current % 5 !== 0) {
            printFizz();
            this.current++;
        } else {
            await new Promise(resolve => setTimeout(resolve, 0));
        }
    }
};

FizzBuzz.prototype.buzz = async function(printBuzz) {
    while (this.current <= this.n) {
        if (this.current % 5 === 0 && this.current % 3 !== 0) {
            printBuzz();
            this.current++;
        } else {
            await new Promise(resolve => setTimeout(resolve, 0));
        }
    }
};

FizzBuzz.prototype.fizzbuzz = async function(printFizzBuzz) {
    while (this.current <= this.n) {
        if (this.current % 15 === 0) {
            printFizzBuzz();
            this.current++;
        } else {
            await new Promise(resolve => setTimeout(resolve, 0));
        }
    }
};

FizzBuzz.prototype.number = async function(printNumber) {
    while (this.current <= this.n) {
        if (this.current % 3 !== 0 && this.current % 5 !== 0) {
            printNumber(this.current);
            this.current++;
        } else {
            await new Promise(resolve => setTimeout(resolve, 0));
        }
    }
};