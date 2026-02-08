var analyzeSubscriptions = function(data) {
    const userMap = new Map();
    const result = [];

    for (const [userId, subscribeDate, serviceType] of data) {
        if (!userMap.has(userId)) {
            userMap.set(userId, {
                subscribeDate: subscribeDate,
                serviceType: serviceType,
                conversionDate: null
            });
        } else {
            const user = userMap.get(userId);
            if (user.serviceType === 'trial' && serviceType === 'premium') {
                user.conversionDate = subscribeDate;
            }
        }
    }

    for (const [userId, user] of userMap) {
        if (user.serviceType === 'premium' && user.conversionDate) {
            result.push([userId, user.subscribeDate, user.conversionDate]);
        }
    }

    return result.sort((a, b) => a[0].localeCompare(b[0]));
};