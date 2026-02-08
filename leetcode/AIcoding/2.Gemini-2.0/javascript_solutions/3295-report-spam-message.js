var reportSpam = function(actions, threshold) {
    const counts = {};
    for (const action of actions) {
        counts[action] = (counts[action] || 0) + 1;
    }

    const result = [];
    for (const action in counts) {
        if (counts[action] > threshold) {
            result.push(action);
        }
    }

    return result;
};