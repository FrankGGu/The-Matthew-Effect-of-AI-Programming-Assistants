var DiningPhilosophers = function() {

};

DiningPhilosophers.prototype.wantsToEat = async function(philosopher, pickLeftChopstick, pickRightChopstick, eat, putLeftChopstick, putRightChopstick) {
    if (philosopher === 0) {
        await pickRightChopstick();
        await pickLeftChopstick();
    } else {
        await pickLeftChopstick();
        await pickRightChopstick();
    }

    await eat();

    if (philosopher === 0) {
        await putRightChopstick();
        await putLeftChopstick();
    } else {
        await putLeftChopstick();
        await putRightChopstick();
    }
};