function countStudents(students, sandwiches) {
    const queue = [...students];
    let index = 0;

    while (queue.length > 0 && index < sandwiches.length) {
        if (queue[0] === sandwiches[index]) {
            queue.shift();
            index++;
        } else {
            break;
        }
    }

    return queue.length;
}