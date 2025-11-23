class Foo {
    constructor() {
        this.firstDone = false;
        this.secondDone = false;
    }

    async first(printFirst) {
        await printFirst();
        this.firstDone = true;
    }

    async second(printSecond) {
        while (!this.firstDone) {
            await new Promise(resolve => setTimeout(resolve, 1));
        }
        await printSecond();
        this.secondDone = true;
    }

    async third(printThird) {
        while (!this.secondDone) {
            await new Promise(resolve => setTimeout(resolve, 1));
        }
        await printThird();
    }
}