function splitMessage(message, limit) {
    const result = [];
    let currentLength = 0;
    let part = 1;
    let maxPartLength = limit - String(part).length - 2; // 2 for "[]"

    while (currentLength < message.length) {
        if (maxPartLength <= 0) break;
        const nextLength = Math.min(message.length - currentLength, maxPartLength);
        result.push(message.slice(currentLength, currentLength + nextLength) + ` [${part}]`);
        currentLength += nextLength;
        part++;
        maxPartLength = limit - String(part).length - 2;
    }

    return result;
}