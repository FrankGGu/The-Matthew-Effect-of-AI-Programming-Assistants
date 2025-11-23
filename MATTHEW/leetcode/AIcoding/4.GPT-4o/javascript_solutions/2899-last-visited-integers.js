function findLastVisitedIntegers(arr) {
    const stack = [];
    const result = [];

    for (let i = 0; i < arr.length; i++) {
        while (stack.length > 0 && stack[stack.length - 1] < arr[i]) {
            result.pop();
            stack.pop();
        }
        stack.push(arr[i]);
        result.push(arr[i]);
    }

    return result;
}