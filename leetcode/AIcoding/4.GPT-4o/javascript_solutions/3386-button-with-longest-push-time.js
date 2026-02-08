var longestPushTime = function(buttons) {
    let maxTime = 0;
    let buttonIndex = -1;

    for (let i = 0; i < buttons.length; i++) {
        if (buttons[i] > maxTime) {
            maxTime = buttons[i];
            buttonIndex = i + 1;
        }
    }

    return buttonIndex;
};