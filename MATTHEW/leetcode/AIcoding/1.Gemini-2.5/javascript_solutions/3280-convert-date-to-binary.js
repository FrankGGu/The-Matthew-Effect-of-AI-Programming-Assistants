var convertDateToBinary = function(dateString) {
    const date = new Date(dateString);
    const timestamp = date.getTime();
    return timestamp.toString(2);
};