package main

type Dynasty struct {
	Name      string
	StartYear int // BC years are negative, AD years are positive
	EndYear   int
}

var dynasties = []Dynasty{
	{"Xia Dynasty", -2070, -1600},
	{"Shang Dynasty", -1600, -1046},
	{"Zhou Dynasty", -1046, -256},
	{"Qin Dynasty", -221, -207},
	{"Han Dynasty", -206, 220},
	{"Three Kingdoms", 220, 280},
	{"Jin Dynasty", 265, 420},
	{"Southern and Northern Dynasties", 420, 589},
	{"Sui Dynasty", 581, 618},
	{"Tang Dynasty", 618, 907},
	{"Five Dynasties and Ten Kingdoms", 907, 960},
	{"Song Dynasty", 960, 1279},
	{"Yuan Dynasty", 1271, 1368},
	{"Ming Dynasty", 1368, 1644},
	{"Qing Dynasty", 1644, 1912},
	{"Republic of China", 1912, 1949},
	{"People's Republic of China", 1949, 9999},
}

func getDynasty(year int) string {
	for _, d := range dynasties {
		if year >= d.StartYear && year <= d.EndYear {
			return d.Name
		}
	}
	return "Unknown"
}