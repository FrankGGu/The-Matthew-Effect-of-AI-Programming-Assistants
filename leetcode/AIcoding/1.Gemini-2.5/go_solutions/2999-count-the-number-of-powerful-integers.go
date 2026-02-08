func numberOfPowerfulInt(start int64, finish int64, limit string, suffix int64) int64 {
	return countPowerful(finish, limit, suffix) - countPowerful(start-1, limit, suffix)
}

func count