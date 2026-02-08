var rotateString = function(s, goal) {
    if (s.length !== goal.length) {
        return -1;
    }

    if (s === goal) {
        return 0;
    }

    const doubledS = s + s;
    const index = doubledS.indexOf(goal);

    return index;
};