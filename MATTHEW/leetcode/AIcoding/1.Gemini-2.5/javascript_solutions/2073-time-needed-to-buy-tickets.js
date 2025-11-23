var timeRequiredToBuy = function(tickets, k) {
    let time = 0;
    const targetTickets = tickets[k];

    for (let i = 0; i < tickets.length; i++) {
        if (i <= k) {
            time += Math.min(tickets[i], targetTickets);
        } else {
            time += Math.min(tickets[i], targetTickets - 1);
        }
    }

    return time;
};