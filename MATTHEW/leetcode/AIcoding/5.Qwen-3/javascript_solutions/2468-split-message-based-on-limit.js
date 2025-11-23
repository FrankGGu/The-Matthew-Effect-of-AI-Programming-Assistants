function splitMessage(message, limit) {
    const result = [];
    let index = 0;
    while (index < message.length) {
        const chunk = message.slice(index, index + limit);
        result.push(chunk);
        index += limit;
    }
    return result;
}