var analyzeSubscriptionConversion = function(events) {
    if (!events || events.length === 0) {
        return 0;
    }

    const userEvents = new Map();
    for (const event of events) {
        if (!userEvents.has(event.user_id)) {
            userEvents.set(event.user_id, []);
        }
        userEvents.get(event.user_id).push(event);
    }

    let totalSignups = 0;
    let successfulConversions = 0;

    for (const [userId, userTimeline] of userEvents.entries()) {
        userTimeline.sort((a, b) => new Date(a.timestamp).getTime() - new Date(b.timestamp).getTime());

        let hasSignedUp = false;
        let hasSubscribed = false;

        for (const event of userTimeline) {
            if (event.event_type === 'signup') {
                hasSignedUp = true;
            }
            if (event.event_type === 'subscribe' && hasSignedUp) {
                hasSubscribed = true;
                break;
            }
        }

        if (hasSignedUp) {
            totalSignups++;
        }
        if (hasSubscribed) {
            successfulConversions++;
        }
    }

    return totalSignups === 0 ? 0 : (successfulConversions / totalSignups) * 100;
};