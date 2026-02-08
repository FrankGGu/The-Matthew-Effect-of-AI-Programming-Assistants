function canReach(target, maxJump) {
    if (target === 0) return true;
    if (target < 0) target = -target;

    let position = 0;
    for (let jump = 1; jump <= maxJump; jump++) {
        position += jump;
        if (position >= target) return true;
    }
    return false;
}