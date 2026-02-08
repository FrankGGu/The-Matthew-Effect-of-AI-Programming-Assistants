function alternatingGroups(arr) {
    let n = arr.length;
    let result = [];
    let group = [];

    for (let i = 0; i < n; i++) {
        if (group.length === 0 || (group.length % 2 === 0 && arr[i] > group[group.length - 1]) || (group.length % 2 === 1 && arr[i] < group[group.length - 1])) {
            group.push(arr[i]);
        } else {
            result.push(group);
            group = [arr[i]];
        }
    }

    if (group.length > 0) {
        result.push(group);
    }

    return result;
}