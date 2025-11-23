var countCollisions = function(directions) {
    let stack = [];
    for (let dir of directions) {
        if (stack.length === 0) {
            stack.push(dir);
        } else {
            let last = stack[stack.length - 1];
            if (last === 'R' && dir === 'L') {
                stack.pop();
                stack.push('S');
            } else if (last === 'S' && dir === 'L') {
                stack.push('S');
            } else {
                stack.push(dir);
            }
        }
    }
    let count = 0;
    for (let i = 0; i < stack.length; i++) {
        if (stack[i] === 'S') {
            count++;
        }
    }
    return count;
};