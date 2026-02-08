class Foo {
    constructor() {
        this.firstDone = false;
        this.secondDone = false;
    }

    first(callback) {
        // print "first"
        callback();
        this.firstDone = true;
    }

    second(callback) {
        // wait for first to be done
        while (!this.firstDone) {}
        // print "second"
        callback();
        this.secondDone = true;
    }

    third(callback) {
        // wait for second to be done
        while (!this.secondDone) {}
        // print "third"
        callback();
    }
}