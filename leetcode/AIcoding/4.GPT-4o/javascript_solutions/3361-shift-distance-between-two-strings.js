function canShift(s, goal) {
    if (s.length !== goal.length) return false;
    const doubledS = s + s;
    return doubledS.includes(goal);
}