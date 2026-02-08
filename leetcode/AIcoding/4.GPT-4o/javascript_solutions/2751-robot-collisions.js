var robotCollision = function(robots) {
    const stack = [];

    for (const robot of robots) {
        while (robot === 'R' || (robot === 'S' && stack[stack.length - 1] === 'R')) {
            if (robot === 'R') {
                stack.push(robot);
                break;
            } else {
                stack.pop();
            }
        }

        if (robot === 'L') {
            while (stack.length && stack[stack.length - 1] === 'R') {
                stack.pop();
            }
            if (!stack.length || stack[stack.length - 1] === 'L') {
                stack.push(robot);
            }
        }
    }

    return stack;
};