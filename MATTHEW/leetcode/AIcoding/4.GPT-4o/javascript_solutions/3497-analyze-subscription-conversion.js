function analyzeSubscriptionConversion(data) {
    const conversions = {};
    const totalSubscriptions = {};

    for (const entry of data) {
        const date = entry[0];
        const isConverted = entry[1];

        if (!totalSubscriptions[date]) {
            totalSubscriptions[date] = 0;
            conversions[date] = 0;
        }

        totalSubscriptions[date]++;
        if (isConverted) {
            conversions[date]++;
        }
    }

    const result = [];
    for (const date of Object.keys(totalSubscriptions).sort()) {
        const conversionRate = (conversions[date] / totalSubscriptions[date]) * 100;
        result.push([date, conversionRate.toFixed(2)]);
    }

    return result;
}