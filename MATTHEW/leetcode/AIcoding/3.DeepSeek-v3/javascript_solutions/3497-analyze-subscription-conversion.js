var analyzeConversion = function(logs) {
    const conversionMap = {};
    const subscriptionMap = {};
    const result = {};

    for (const log of logs) {
        const [timestamp, user, action] = log.split(' ');
        if (action === 'PURCHASE') {
            if (subscriptionMap[user]) {
                const subscriptionType = subscriptionMap[user];
                if (!result[subscriptionType]) {
                    result[subscriptionType] = { converted: 0, total: 0 };
                }
                result[subscriptionType].converted++;
                delete subscriptionMap[user];
            }
        } else {
            if (!subscriptionMap[user]) {
                subscriptionMap[user] = action;
                if (!conversionMap[action]) {
                    conversionMap[action] = 0;
                }
                conversionMap[action]++;
            }
        }
    }

    for (const [subscriptionType, count] of Object.entries(conversionMap)) {
        if (!result[subscriptionType]) {
            result[subscriptionType] = { converted: 0, total: count };
        } else {
            result[subscriptionType].total = count;
        }
    }

    const sortedResult = {};
    Object.keys(result).sort().forEach(key => {
        sortedResult[key] = result[key];
    });

    for (const key in sortedResult) {
        const rate = sortedResult[key].total === 0 ? 0 : (sortedResult[key].converted / sortedResult[key].total) * 100;
        sortedResult[key].conversion_rate = parseFloat(rate.toFixed(2));
        delete sortedResult[key].converted;
        delete sortedResult[key].total;
    }

    return sortedResult;
};