function canSeePersonsAtFrontOfQueue(people) {
    const n = people.length;
    const result = new Array(n).fill(0);
    const stack = [];

    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && people[stack[stack.length - 1]] < people[i]) {
            result[i]++;
            stack.pop();
        }
        if (stack.length > 0) {
            result[i]++;
        }
        stack.push(i);
    }

    return result;
}